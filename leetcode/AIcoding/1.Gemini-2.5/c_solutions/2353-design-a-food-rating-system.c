#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#include "uthash.h"

typedef struct FoodInfoEntry {
    char *foodName; // Key for uthash (food name)
    char *cuisine;  // Cuisine of the food
    int rating;     // Current rating of the food
    UT_hash_handle hh; // UTHash handle
} FoodInfoEntry;

typedef struct FoodRatingNode {
    char *foodName; // Food name (strdup'd)
    int rating;     // Food rating
    struct FoodRatingNode *left;  // Left child
    struct FoodRatingNode *right; // Right child
    int height;     // Height of the node for AVL balancing
} FoodRatingNode;

typedef struct CuisineInfoEntry {
    char *cuisineName; // Key for uthash (cuisine name)
    FoodRatingNode *bstRoot; // Root of the AVL tree for this cuisine
    UT_hash_handle hh; // UTHash handle
} CuisineInfoEntry;

typedef struct {
    FoodInfoEntry *foodMap;       // Hash map: foodName -> FoodInfoEntry
    CuisineInfoEntry *cuisineMap; // Hash map: cuisineName -> CuisineInfoEntry (which holds an AVL tree root)
} FoodRatings;

int getHeight(FoodRatingNode *node) {
    if (node == NULL) return 0;
    return node->height;
}

void updateHeight(FoodRatingNode *node) {
    if (node) {
        node->height = 1 + (getHeight(node->left) > getHeight(node->right) ? getHeight(node->left) : getHeight(node->right));
    }
}

int getBalance(FoodRatingNode *node) {
    if (node == NULL) return 0;
    return getHeight(node->left) - getHeight(node->right);
}

FoodRatingNode *newNode(const char *foodName, int rating) {
    FoodRatingNode *node = (FoodRatingNode *)malloc(sizeof(FoodRatingNode));
    node->foodName = strdup(foodName); // Duplicate string for ownership
    node->rating = rating;
    node->left = NULL;
    node->right = NULL;
    node->height = 1; // New node is initially a leaf
    return node;
}

FoodRatingNode *rightRotate(FoodRatingNode *y) {
    FoodRatingNode *x = y->left;
    FoodRatingNode *T2 = x->right;

    x->right = y;
    y->left = T2;

    updateHeight(y); // Update heights of affected nodes
    updateHeight(x);

    return x; // New root
}

FoodRatingNode *leftRotate(FoodRatingNode *x) {
    FoodRatingNode *y = x->right;
    FoodRatingNode *T2 = y->left;

    y->left = x;
    x->right = T2;

    updateHeight(x); // Update heights of affected nodes
    updateHeight(y);

    return y; // New root
}

int compareFoodRatingNodes(const FoodRatingNode *a, const char *foodName_b, int rating_b) {
    // If b has a higher rating than a, b is "smaller" (goes left)
    if (rating_b > a->rating) {
        return -1;
    }
    // If b has a lower rating than a, b is "larger" (goes right)
    if (rating_b < a->rating) {
        return 1;
    }
    // Ratings are equal, compare food names lexicographically
    // If b's foodName is lexicographically smaller than a's, b is "smaller" (goes left)
    int name_cmp = strcmp(foodName_b, a->foodName);
    if (name_cmp < 0) {
        return -1;
    }
    // If b's foodName is lexicographically larger than a's, b is "larger" (goes right)
    if (name_cmp > 0) {
        return 1;
    }
    // Exact match (should only happen for deletion when matching the exact node)
    return 0;
}

FoodRatingNode *insertNode(FoodRatingNode *node, const char *foodName, int rating) {
    if (node == NULL) {
        return newNode(foodName, rating);
    }

    int cmp = compareFoodRatingNodes(node, foodName, rating);

    if (cmp < 0) { // New (rating, foodName) is "smaller", go left
        node->left = insertNode(node->left, foodName, rating);
    } else if (cmp > 0) { // New (rating, foodName) is "larger", go right
        node->right = insertNode(node->right, foodName, rating);
    } else { // Exact match (should not happen for unique food names in problem context)
        return node;
    }

    updateHeight(node); // Update height of current node

    int balance = getBalance(node); // Get balance factor for current node

    // Perform rotations if unbalanced
    // Left Left Case
    if (balance > 1 && compareFoodRatingNodes(node->left, foodName, rating) < 0) {
        return rightRotate(node);
    }

    // Right Right Case
    if (balance < -1 && compareFoodRatingNodes(node->right, foodName, rating) > 0) {
        return leftRotate(node);
    }

    // Left Right Case
    if (balance > 1 && compareFoodRatingNodes(node->left, foodName, rating) > 0) {
        node->left = leftRotate(node->left);
        return rightRotate(node);
    }

    // Right Left Case
    if (balance < -1 && compareFoodRatingNodes(node->right, foodName, rating) < 0) {
        node->right = rightRotate(node->right);
        return leftRotate(node);
    }

    return node; // Return the (potentially new) root of the subtree
}

FoodRatingNode *minValueNode(FoodRatingNode *node) {
    FoodRatingNode *current = node;
    while (current != NULL && current->left != NULL) {
        current = current->left;
    }
    return current;
}

FoodRatingNode *deleteNode(FoodRatingNode *root, const char *foodName, int rating) {
    if (root == NULL) {
        return root;
    }

    int cmp = compareFoodRatingNodes(root, foodName, rating);

    if (cmp < 0) { // Target is "smaller", go left
        root->left = deleteNode(root->left, foodName, rating);
    } else if (cmp > 0) { // Target is "larger", go right
        root->right = deleteNode(root->right, foodName, rating);
    } else { // Found the node to delete (exact match)
        // Node with only one child or no child
        if ((root->left == NULL) || (root->right == NULL)) {
            FoodRatingNode *temp = root->left ? root->left : root->right;

            // No child case
            if (temp == NULL) {
                free(root->foodName);
                free(root);
                root = NULL;
            } else { // One child case
                FoodRatingNode *to_free = root;
                root = temp; // Make the child the new root
                free(to_free->foodName);
                free(to_free);
            }
        } else {
            // Node with two children: Get the inorder successor (smallest in the right subtree)
            FoodRatingNode *temp = minValueNode(root->right);

            // Copy the inorder successor's data to this node
            free(root->foodName); // Free old name
            root->foodName = strdup(temp->foodName); // Copy new name
            root->rating = temp->rating;

            // Delete the inorder successor from its original position
            root->right = deleteNode(root->right, temp->foodName, temp->rating);
        }
    }

    if (root == NULL) { // If the tree became empty after deletion
        return root;
    }

    updateHeight(root); // Update height of current node
    int balance = getBalance(root); // Get balance factor

    // Perform rotations if unbalanced
    // Left Left Case
    if (balance > 1 && getBalance(root->left) >= 0) {
        return rightRotate(root);
    }

    // Left Right Case
    if (balance > 1 && getBalance(root->left) < 0) {
        root->left = leftRotate(root->left);
        return rightRotate(root);
    }

    // Right Right Case
    if (balance < -1 && getBalance(root->right) <= 0) {
        return leftRotate(root);
    }

    // Right Left Case
    if (balance < -1 && getBalance(root->right) > 0) {
        root->right = rightRotate(root->right);
        return leftRotate(root);
    }

    return root; // Return the (potentially new) root of the subtree
}

FoodRatingNode *findHighestRated(FoodRatingNode *root) {
    FoodRatingNode *current = root;
    if (current == NULL) return NULL; // Should not happen for existing cuisine
    while (current->left != NULL) {
        current = current->left;
    }
    return current;
}

void freeFoodRatingNode(FoodRatingNode *node) {
    if (node == NULL) return;
    freeFoodRatingNode(node->left);
    freeFoodRatingNode(node->right);
    free(node->foodName); // Free duplicated string
    free(node);           // Free node structure
}

FoodRatings *foodRatingsCreate(char **foods, char **cuisines, int *ratings, int N) {
    FoodRatings *obj = (FoodRatings *)malloc(sizeof(FoodRatings));
    obj->foodMap = NULL;    // Initialize uthash map to NULL
    obj->cuisineMap = NULL; // Initialize uthash map to NULL

    for (int i = 0; i < N; i++) {
        // 1. Add/Update food information in foodMap
        FoodInfoEntry *foodEntry = (FoodInfoEntry *)malloc(sizeof(FoodInfoEntry));
        foodEntry->foodName = strdup(foods[i]);    // Duplicate food name
        foodEntry->cuisine = strdup(cuisines[i]);  // Duplicate cuisine name
        foodEntry->rating = ratings[i];
        HASH_ADD_STR(obj->foodMap, foodName, foodEntry); // Add to foodMap

        // 2. Add/Update cuisine information and its AVL tree in cuisineMap
        CuisineInfoEntry *cuisineEntry;
        HASH_FIND_STR(obj->cuisineMap, cuisines[i], cuisineEntry);

        if (cuisineEntry == NULL) {
            // If cuisine doesn't exist, create a new entry
            cuisineEntry = (CuisineInfoEntry *)malloc(sizeof(CuisineInfoEntry));
            cuisineEntry->cuisineName = strdup(cuisines[i]); // Duplicate cuisine name
            cuisineEntry->bstRoot = NULL; // Initialize AVL tree root to NULL
            HASH_ADD_STR(obj->cuisineMap, cuisineName, cuisineEntry); // Add to cuisineMap
        }
        // Insert the food into the cuisine's AVL tree
        cuisineEntry->bstRoot = insertNode(cuisineEntry->bstRoot, foods[i], ratings[i]);
    }
    return obj;
}

void foodRatingsChangeRating(FoodRatings *obj, char *food, int newRating) {
    FoodInfoEntry *foodEntry;
    HASH_FIND_STR(obj->foodMap, food, foodEntry);

    // Problem constraints guarantee food exists.
    char *cuisine = foodEntry->cuisine;   // Get cuisine from food entry
    char *foodName = foodEntry->foodName; // Get persistent food name string
    int oldRating = foodEntry->rating;    // Get old rating

    // 1. Update the rating in foodMap
    foodEntry->rating = newRating;

    // 2. Update the cuisine's AVL tree
    CuisineInfoEntry *cuisineEntry;
    HASH_FIND_STR(obj->cuisineMap, cuisine, cuisineEntry);

    // Delete the old food node from the AVL tree
    cuisineEntry->bstRoot = deleteNode(cuisineEntry->bstRoot, foodName, oldRating);
    // Insert the new food node with the updated rating into the AVL tree
    cuisineEntry->bstRoot = insertNode(cuisineEntry->bstRoot, foodName, newRating);
}

char *foodRatingsHighestRated(FoodRatings *obj, char *cuisine) {
    CuisineInfoEntry *cuisineEntry;
    HASH_FIND_STR(obj->cuisineMap, cuisine, cuisineEntry);

    // Problem constraints guarantee cuisine exists.
    // Find the leftmost node in the cuisine's AVL tree, which represents the highest-rated food.
    FoodRatingNode *highest = findHighestRated(cuisineEntry->bstRoot);
    return highest->foodName; // Return the food name string
}

void foodRatingsFree(FoodRatings *obj) {
    FoodInfoEntry *currentFood, *tmpFood;
    // Iterate through foodMap to free entries
    HASH_ITER(hh, obj->foodMap, currentFood, tmpFood) {
        HASH_DEL(obj->foodMap, currentFood); // Remove from hash table
        free(currentFood->foodName);         // Free duplicated food name
        free(currentFood->cuisine);          // Free duplicated cuisine name
        free(currentFood);                   // Free FoodInfoEntry structure
    }

    CuisineInfoEntry *currentCuisine, *tmpCuisine;
    // Iterate through cuisineMap to free entries and their AVL trees
    HASH_ITER(hh, obj->cuisineMap, currentCuisine, tmpCuisine) {
        HASH_DEL(obj->cuisineMap, currentCuisine); // Remove from hash table
        freeFoodRatingNode(currentCuisine->bstRoot); // Recursively free all nodes in the AVL tree
        free(currentCuisine->cuisineName);           // Free duplicated cuisine name
        free(currentCuisine);                        // Free CuisineInfoEntry structure
    }
    free(obj); // Free the main FoodRatings object
}