/**
 * *********************************************************************
 * // This is the interface that allows for creating nested lists.
 * // You should not implement it, or speculate about its implementation
 * *********************************************************************
 *
 * // Initializes an empty nested list and return a nested list integer s.
 * struct NestedInteger *NestedIntegerInit();
 *
 * // Return true if this NestedInteger holds a single integer, rather than a nested list.
 * bool NestedIntegerIsInteger(struct NestedInteger *);
 *
 * // Return the single integer that this NestedInteger holds, if it holds a single integer
 * // The result is undefined if this NestedInteger holds a nested list
 * int NestedIntegerGetInteger(struct NestedInteger *);
 *
 * // Set this NestedInteger to hold a single integer.
 * void NestedIntegerSetInteger(struct NestedInteger *ni, int value);
 *
 * // Set this NestedInteger to hold a nested list and adds a nested integer elem to it.
 * void NestedIntegerAdd(struct NestedInteger *ni, struct NestedInteger *elem);
 *
 * // Return the nested list that this NestedInteger holds, if it holds a nested list
 * // The result is undefined if this NestedInteger holds a single integer
 * struct NestedInteger **NestedIntegerGetList(struct NestedInteger *);
 *
 * // Return the nested list's size that this NestedInteger holds, if it holds a nested list
 * // The result is undefined if this NestedInteger holds a single integer
 * int NestedIntegerGetListSize(struct NestedInteger *);
 * };
 */

struct NestedInteger* deserialize(char* s) {
    if (s[0] != '[') {
        struct NestedInteger* ni = NestedIntegerInit();
        int num = atoi(s);
        NestedIntegerSetInteger(ni, num);
        return ni;
    }

    struct NestedInteger* stack[1000];
    int top = -1;
    struct NestedInteger* curr = NULL;
    char* numStr = NULL;
    int numStart = -1;

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '[') {
            struct NestedInteger* newNi = NestedIntegerInit();
            if (curr != NULL) {
                NestedIntegerAdd(curr, newNi);
                stack[++top] = curr;
            }
            curr = newNi;
        } else if (s[i] == ']' || s[i] == ',') {
            if (numStart != -1) {
                char temp = s[i];
                s[i] = '\0';
                int num = atoi(s + numStart);
                s[i] = temp;

                struct NestedInteger* numNi = NestedIntegerInit();
                NestedIntegerSetInteger(numNi, num);
                NestedIntegerAdd(curr, numNi);
                numStart = -1;
            }

            if (s[i] == ']' && top >= 0) {
                curr = stack[top--];
            }
        } else if (s[i] == '-') {
            numStart = i;
        } else if (s[i] >= '0' && s[i] <= '9') {
            if (numStart == -1) {
                numStart = i;
            }
        }
    }

    return curr;
}