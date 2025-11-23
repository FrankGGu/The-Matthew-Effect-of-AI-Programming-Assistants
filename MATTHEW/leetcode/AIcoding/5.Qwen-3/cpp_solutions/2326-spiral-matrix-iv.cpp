#include <iostream>
#include <vector>
#include <ListNode.h>

using namespace std;

class Solution {
public:
    vector<int> spiralMatrix(int m, int n, ListNode* head) {
        vector<int> result(m * n);
        int top = 0, bottom = m - 1, left = 0, right = n - 1;
        int index = 0;

        while (head && top <= bottom && left <= right) {
            for (int i = left; i <= right && head; ++i) {
                result[index++] = head->val;
                head = head->next;
            }
            top++;

            for (int i = top; i <= bottom && head; ++i) {
                result[index++] = head->val;
                head = head->next;
            }
            right--;

            for (int i = right; i >= left && head; --i) {
                result[index++] = head->val;
                head = head->next;
            }
            bottom--;

            for (int i = bottom; i >= top && head; --i) {
                result[index++] = head->val;
                head = head->next;
            }
            left++;
        }

        return result;
    }
};