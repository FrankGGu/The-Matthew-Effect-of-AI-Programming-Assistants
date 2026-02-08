#include <stdlib.h>

#ifndef min
#define min(a, b) (((a) < (b)) ? (a) : (b))
#endif
#ifndef max
#define max(a, b) (((a) > (b)) ? (a) : (b))
#endif

enum Color { RED, BLACK };

typedef struct RBNode {
    int start;
    int end;
    enum Color color;
    struct RBNode *parent;
    struct RBNode *left;
    struct RBNode *right;
} RBNode;

RBNode *NIL_NODE;

void init_nil_node() {
    if (NIL_NODE == NULL) {
        NIL_NODE = (RBNode *)malloc(sizeof(RBNode));
        NIL_NODE->color = BLACK;
        NIL_NODE->left = NULL;
        NIL_NODE->right = NULL;
        NIL_NODE->parent = NULL;
        NIL_NODE->start = 0; // Dummy values
        NIL_NODE->end = 0;   // Dummy values
    }
}

RBNode *create_rb_node(int start, int end) {
    RBNode *node = (RBNode *)malloc(sizeof(RBNode));
    node->start = start;
    node->end = end;
    node->color = RED; // New nodes are always RED
    node->parent = NIL_NODE;
    node->left = NIL_NODE;
    node->right = NIL_NODE;
    return node;
}

void rb_insert_fixup(RBNode **root, RBNode *z);
void rb_delete_fixup(RBNode **root, RBNode *x, RBNode *x_parent);
void rb_left_rotate(RBNode **root, RBNode *x);
void rb_right_rotate(RBNode **root, RBNode *y);
void rb_transplant(RBNode **root, RBNode *u, RBNode *v);
RBNode *rb_minimum(RBNode *node);
RBNode *rb_maximum(RBNode *node);
RBNode *rb_successor(RBNode *x);
RBNode *rb_predecessor(RBNode *x);

void rb_left_rotate(RBNode **root, RBNode *x) {
    RBNode *y = x->right;
    x->right = y->left;
    if (y->left != NIL_NODE) {
        y->left->parent = x;
    }
    y->parent = x->parent;
    if (x->parent == NIL_NODE) {
        *root = y;
    } else if (x == x->parent->left) {
        x->parent->left = y;
    } else {
        x->parent->right = y;
    }
    y->left = x;
    x->parent = y;
}

void rb_right_rotate(RBNode **root, RBNode *y) {
    RBNode *x = y->left;
    y->left = x->right;
    if (x->right != NIL_NODE) {
        x->right->parent = y;
    }
    x->parent = y->parent;
    if (y->parent == NIL_NODE) {
        *root = x;
    } else if (y == y->parent->left) {
        y->parent->left = x;
    } else {
        y->parent->right = x;
    }
    x->right = y;
    y->parent = x;
}

void rb_insert_fixup(RBNode **root, RBNode *z) {
    while (z->parent->color == RED) {
        if (z->parent == z->parent->parent->left) {
            RBNode *y = z->parent->parent->right; // Uncle
            if (y->color == RED) {
                z->parent->color = BLACK;
                y->color = BLACK;
                z->parent->parent->color = RED;
                z = z->parent->parent;
            } else {
                if (z == z->parent->right) {
                    z = z->parent;
                    rb_left_rotate(root, z);
                }
                z->parent->color = BLACK;
                z->parent->parent->color = RED;
                rb_right_rotate(root, z->parent->parent);
            }
        } else { // Symmetric case
            RBNode *y = z->parent->parent->left; // Uncle
            if (y->color == RED) {
                z->parent->color = BLACK;
                y->color = BLACK;
                z->parent->parent->color = RED;
                z = z->parent->parent;
            } else {
                if (z == z->parent->left) {
                    z = z->parent;
                    rb_right_rotate(root, z);
                }
                z->parent->color = BLACK;
                z->parent->parent->color = RED;
                rb_left_rotate(root, z->parent->parent);
            }
        }
    }
    (*root)->color = BLACK;
}

void rb_insert(RBNode **root, RBNode *z) {
    RBNode *y = NIL_NODE;
    RBNode *x = *root;

    while (x != NIL_NODE) {
        y = x;
        if (z->start < x->start) {
            x = x->left;
        } else {
            x = x->right;
        }
    }
    z->parent = y;
    if (y == NIL_NODE) {
        *root = z;
    } else if (z->start < y->start) {
        y->left = z;
    } else {
        y->right = z;
    }
    rb_insert_fixup(root, z);
}

void rb_transplant(RBNode **root, RBNode *u, RBNode *v) {
    if (u->parent == NIL_NODE) {
        *root = v;
    } else if (u == u->parent->left) {
        u->parent->left = v;
    } else {
        u->parent->right = v;
    }
    v->parent = u->parent;
}

RBNode *rb_minimum(RBNode *node) {
    while (node->left != NIL_NODE) {
        node = node->left;
    }
    return node;
}

RBNode *rb_maximum(RBNode *node) {
    if (node == NIL_NODE) return NIL_NODE;
    while (node->right != NIL_NODE) {
        node = node->right;
    }
    return node;
}

RBNode *rb_successor(RBNode *x) {
    if (x == NIL_NODE) return NIL_NODE;
    if (x->right != NIL_NODE) {
        return rb_minimum(x->right);
    }
    RBNode *y = x->parent;
    while (y != NIL_NODE && x == y->right) {
        x = y;
        y = y->parent;
    }
    return y;
}

RBNode *rb_predecessor(RBNode *x) {
    if (x == NIL_NODE) return NIL_NODE;
    if (x->left != NIL_NODE) {
        return rb_maximum(x->left);
    }
    RBNode *y = x->parent;
    while (y != NIL_NODE && x == y->left) {
        x = y;
        y = y->parent;
    }
    return y;
}

void rb_delete_fixup(RBNode **root, RBNode *x, RBNode *x_parent) {
    while (x != *root && x->color == BLACK) {
        if (x == x_parent->left) {
            RBNode *w = x_parent->right; // Sibling
            if (w->color == RED) {
                w->color = BLACK;
                x_parent->color = RED;
                rb_left_rotate(root, x_parent);
                w = x_parent->right;
            }
            if (w->left->color == BLACK && w->right->color == BLACK) {
                w->color = RED;
                x = x_parent;
                x_parent = x->parent;
            } else {
                if (w->right->color == BLACK) {
                    w->left->color = BLACK;
                    w->color = RED;
                    rb_right_rotate(root, w);
                    w = x_parent->right;
                }
                w->color = x_parent->color;
                x_parent->color = BLACK;
                w->right->color = BLACK;
                rb_left_rotate(root, x_parent);
                x = *root; // To terminate loop
            }
        } else { // Symmetric case
            RBNode *w = x_parent->left; // Sibling
            if (w->color == RED) {
                w->color = BLACK;
                x_parent->color = RED;
                rb_right_rotate(root, x_parent);
                w = x_parent->left;
            }
            if (w->left->color == BLACK && w->right->color == BLACK) {
                w->color = RED;
                x = x_parent;
                x_parent = x->parent;
            } else {
                if (w->left->color == BLACK) {
                    w->right->color = BLACK;
                    w->color = RED;
                    rb_left_rotate(root, w);
                    w = x_parent->left;
                }
                w->color = x_parent->color;
                x_parent->color = BLACK;
                w->left->color = BLACK;
                rb_right_rotate(root, x_parent);
                x = *root; // To terminate loop
            }
        }
    }
    if (x != NIL_NODE) x->color = BLACK;
}

void rb_delete(RBNode **root, RBNode *z) {
    RBNode *y = z;
    RBNode *x;
    RBNode *x_parent; // Parent of x, needed for fixup if x is NIL_NODE

    enum Color y_original_color = y->color;

    if (z->left == NIL_NODE) {
        x = z->right;
        x_parent = z->parent;
        rb_transplant(root, z, z->right);
    } else if (z->right == NIL_NODE) {
        x = z->left;
        x_parent = z->parent;
        rb_transplant(root, z, z->left);
    } else {
        y = rb_minimum(z->right);
        y_original_color = y->color;
        x = y->right;

        if (y->parent == z) { 
            x_parent = y; 
        } else { 
            x_parent = y->parent;
            rb_transplant(root, y, y->right);
            y->right = z->right;
            y->right->parent = y;
        }
        rb_transplant(root, z, y); 
        y->left = z->left;
        y->left->parent = y;
        y->color = z->color;
    }

    if (y_original_color == BLACK) {
        rb_delete_fixup(root, x, x_parent);
    }
    free(z);
}

RBNode *rb_upper_bound(RBNode *root, int key) {
    RBNode *current = root;
    RBNode *result = NIL_NODE;

    while (current != NIL_NODE) {
        if (current->start > key) {
            result = current;
            current = current->left;
        } else {
            current = current->right;
        }
    }
    return result;
}

typedef struct {
    RBNode *root;
    long long total_covered;
} CountIntervals;

CountIntervals* countIntervalsCreate() {
    init_nil_node(); // Ensure NIL_NODE is initialized
    CountIntervals *obj = (CountIntervals *)malloc(sizeof(CountIntervals));
    obj->root = NIL_NODE;
    obj->total_covered = 0;
    return obj;
}

void countIntervalsAdd(CountIntervals* obj, int left, int right) {
    RBNode *current = rb_upper_bound(obj->root, left);

    if (current != NIL_NODE) {
        RBNode *pred = rb_predecessor(current);
        if (pred != NIL_NODE && pred->end >= left - 1) {
            current = pred; 
        }
    } else { 
        current = rb_maximum(obj->root);
    }

    int merge_left = left;
    int merge_right = right;

    RBNode *node_to_delete = current;
    while (node_to_delete != NIL_NODE && node_to_delete->start <= merge_right + 1) {
        if (node_to_delete->end >= merge_left - 1) { 
            merge_left = min(merge_left, node_to_delete->start);
            merge_right = max(merge_right, node_to_delete->end);
            obj->total_covered -= (long long)node_to_delete->end - node_to_delete->start + 1;

            RBNode *next_node = rb_successor(node_to_delete);
            rb_delete(&obj->root, node_to_delete);
            node_to_delete = next_node;
        } else { 
            node_to_delete = rb_successor(node_to_delete);
        }
    }

    RBNode *new_interval_node = create_rb_node(merge_left, merge_right);
    rb_insert(&obj->root, new_interval_node);
    obj->total_covered += (long long)merge_right - merge_left + 1;
}

long long countIntervalsCount(CountIntervals* obj) {
    return obj->total_covered;
}

void free_rb_tree(RBNode *node) {
    if (node != NIL_NODE) {
        free_rb_tree(node->left);
        free_rb_tree(node->right);
        free(node);
    }
}

void countIntervalsFree(CountIntervals* obj) {
    free_rb_tree(obj->root);
    free(obj);
}