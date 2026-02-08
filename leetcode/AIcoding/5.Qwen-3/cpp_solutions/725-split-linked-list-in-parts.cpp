#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(nullptr) {}
};

class Solution {
public:
    vector<ListNode*> splitListToParts(ListNode* root, int k) {
        vector<ListNode*> result;
        int length = 0;
        ListNode* current = root;
        while (current) {
            length++;
            current = current->next;
        }

        int partSize = length / k;
        int remainder = length % k;

        current = root;
        for (int i = 0; i < k; ++i) {
            result.push_back(current);
            int size = partSize + (i < remainder ? 1 : 0);
            for (int j = 0; j < size - 1; ++j) {
                if (current) {
                    current = current->next;
                }
            }
            if (current) {
                ListNode* next = current->next;
                current->next = nullptr;
                current = next;
            }
        }

        return result;
    }
};