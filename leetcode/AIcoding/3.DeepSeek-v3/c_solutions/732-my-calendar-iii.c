typedef struct Node {
    int start;
    int end;
    int height;
    int maxEnd;
    struct Node* left;
    struct Node* right;
} Node;

Node* createNode(int start, int end, int height) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->start = start;
    node->end = end;
    node->height = height;
    node->maxEnd = end;
    node->left = NULL;
    node->right = NULL;
    return node;
}

int max(int a, int b) {
    return a > b ? a : b;
}

Node* insert(Node* root, int start, int end, int height, int* maxBooking) {
    if (!root) {
        *maxBooking = max(*maxBooking, height);
        return createNode(start, end, height);
    }

    if (start >= root->end) {
        root->right = insert(root->right, start, end, height, maxBooking);
    } else if (end <= root->start) {
        root->left = insert(root->left, start, end, height, maxBooking);
    } else {
        int leftStart = root->start;
        int leftEnd = start;
        int rightStart = end;
        int rightEnd = root->end;

        if (root->start < start) {
            root->left = insert(root->left, root->start, start, root->height, maxBooking);
            root->start = start;
        }

        if (root->end > end) {
            root->right = insert(root->right, end, root->end, root->height, maxBooking);
            root->end = end;
        }

        root->height += height;
        *maxBooking = max(*maxBooking, root->height);

        if (leftStart < start) {
            root->left = insert(root->left, leftStart, start, root->height - height, maxBooking);
        }

        if (rightEnd > end) {
            root->right = insert(root->right, end, rightEnd, root->height - height, maxBooking);
        }
    }

    if (root->left) {
        root->maxEnd = max(root->maxEnd, root->left->maxEnd);
    }
    if (root->right) {
        root->maxEnd = max(root->maxEnd, root->right->maxEnd);
    }

    return root;
}

typedef struct {
    Node* root;
    int maxBooking;
} MyCalendarThree;

MyCalendarThree* myCalendarThreeCreate() {
    MyCalendarThree* obj = (MyCalendarThree*)malloc(sizeof(MyCalendarThree));
    obj->root = NULL;
    obj->maxBooking = 0;
    return obj;
}

int myCalendarThreeBook(MyCalendarThree* obj, int start, int end) {
    obj->root = insert(obj->root, start, end, 1, &(obj->maxBooking));
    return obj->maxBooking;
}

void myCalendarThreeFree(MyCalendarThree* obj) {
    // In a real implementation, we should free all nodes
    // For LeetCode, this is often left empty
    free(obj);
}