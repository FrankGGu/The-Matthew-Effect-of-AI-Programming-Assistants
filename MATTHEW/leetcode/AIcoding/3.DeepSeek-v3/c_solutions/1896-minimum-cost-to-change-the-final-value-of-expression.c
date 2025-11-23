typedef struct {
    int val;
    int cost;
} Node;

Node dfs(char* s, int* index) {
    Node left, right;
    if (s[*index] == '0' || s[*index] == '1') {
        left.val = s[*index] - '0';
        left.cost = 0;
        (*index)++;
        return left;
    }

    if (s[*index] == '(') {
        (*index)++;
        left = dfs(s, index);
    }

    char op = s[*index];
    (*index)++;

    if (s[*index] == '(') {
        (*index)++;
        right = dfs(s, index);
    } else {
        right.val = s[*index] - '0';
        right.cost = 0;
        (*index)++;
    }

    (*index)++; // skip ')'

    Node res;
    if (op == '&') {
        if (left.val == 1 && right.val == 1) {
            res.val = 1;
            res.cost = left.cost + right.cost;
        } else if (left.val == 0 && right.val == 0) {
            res.val = 0;
            res.cost = fmin(left.cost, right.cost) + 1;
        } else {
            res.val = 0;
            res.cost = fmin(left.cost + (left.val == 1 ? 1 : 0), 
                           right.cost + (right.val == 1 ? 1 : 0));
        }
    } else { // op == '|'
        if (left.val == 0 && right.val == 0) {
            res.val = 0;
            res.cost = left.cost + right.cost;
        } else if (left.val == 1 && right.val == 1) {
            res.val = 1;
            res.cost = fmin(left.cost, right.cost) + 1;
        } else {
            res.val = 1;
            res.cost = fmin(left.cost + (left.val == 0 ? 1 : 0), 
                           right.cost + (right.val == 0 ? 1 : 0));
        }
    }
    return res;
}

int minOperationsToFlip(char* expression) {
    int index = 0;
    Node result = dfs(expression, &index);
    return result.cost;
}