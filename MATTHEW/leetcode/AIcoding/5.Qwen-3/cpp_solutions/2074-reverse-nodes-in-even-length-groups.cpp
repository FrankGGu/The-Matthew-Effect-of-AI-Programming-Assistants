#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution {
public:
    ListNode* reverseEvenLengthGroups(ListNode* head) {
        vector<ListNode*> nodes;
        while (head) {
            nodes.push_back(head);
            head = head->next;
        }

        int n = nodes.size();
        int k = 1;
        int i = 0;

        while (i < n) {
            int end = min(i + k, n);
            int length = end - i;
            if (length % 2 == 0) {
                reverse(nodes.begin() + i, nodes.begin() + end);
            }
            i += k;
            k++;
        }

        for (int j = 0; j < n - 1; ++j) {
            nodes[j]->next = nodes[j + 1];
        }
        nodes[n - 1]->next = nullptr;

        return nodes[0];
    }
};