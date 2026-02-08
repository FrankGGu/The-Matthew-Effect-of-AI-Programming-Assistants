typedef long long ll;

ll max(ll a, ll b) {
    return a > b ? a : b;
}

typedef struct {
    ll key;
    ll value;
} Pair;

typedef struct Node {
    Pair pair;
    struct Node* left;
    struct Node* right;
    ll max_value;
    int height;
} Node;

int getHeight(Node* node) {
    if (node == NULL) return 0;
    return node->height;
}

ll getMaxValue(Node* node) {
    if (node == NULL) return -1e18;
    return node->max_value;
}

void update(Node* node) {
    if (node == NULL) return;
    node->height = 1 + max(getHeight(node->left), getHeight(node->right));
    node->max_value = max(node->pair.value, max(getMaxValue(node->left), getMaxValue(node->right)));
}

Node* rotateRight(Node* y) {
    Node* x = y->left;
    Node* T2 = x->right;

    x->right = y;
    y->left = T2;

    update(y);
    update(x);

    return x;
}

Node* rotateLeft(Node* x) {
    Node* y = x->right;
    Node* T2 = y->left;

    y->left = x;
    x->right = T2;

    update(x);
    update(y);

    return y;
}

int getBalance(Node* node) {
    if (node == NULL) return 0;
    return getHeight(node->left) - getHeight(node->right);
}

Node* insert(Node* node, ll key, ll value) {
    if (node == NULL) {
        Node* newNode = (Node*)malloc(sizeof(Node));
        newNode->pair.key = key;
        newNode->pair.value = value;
        newNode->left = NULL;
        newNode->right = NULL;
        newNode->height = 1;
        newNode->max_value = value;
        return newNode;
    }

    if (key < node->pair.key) {
        node->left = insert(node->left, key, value);
    } else if (key > node->pair.key) {
        node->right = insert(node->right, key, value);
    } else {
        node->pair.value = max(node->pair.value, value);
        update(node);
        return node;
    }

    update(node);

    int balance = getBalance(node);

    if (balance > 1 && key < node->left->pair.key) {
        return rotateRight(node);
    }

    if (balance < -1 && key > node->right->pair.key) {
        return rotateLeft(node);
    }

    if (balance > 1 && key > node->left->pair.key) {
        node->left = rotateLeft(node->left);
        return rotateRight(node);
    }

    if (balance < -1 && key < node->right->pair.key) {
        node->right = rotateRight(node->right);
        return rotateLeft(node);
    }

    return node;
}

ll query(Node* node, ll key) {
    if (node == NULL) return -1e18;

    if (node->pair.key <= key) {
        ll left_max = getMaxValue(node->left);
        ll current = node->pair.value;
        ll right_max = query(node->right, key);
        return max(left_max, max(current, right_max));
    } else {
        return query(node->left, key);
    }
}

long long maxBalancedSubsequenceSum(int* nums, int numsSize) {
    Node* root = NULL;
    ll result = -1e18;

    for (int i = 0; i < numsSize; i++) {
        ll diff = nums[i] - i;
        ll current = nums[i];
        ll max_val = query(root, diff);
        if (max_val > 0) {
            current += max_val;
        }
        result = max(result, current);
        root = insert(root, diff, current);
    }

    return result;
}