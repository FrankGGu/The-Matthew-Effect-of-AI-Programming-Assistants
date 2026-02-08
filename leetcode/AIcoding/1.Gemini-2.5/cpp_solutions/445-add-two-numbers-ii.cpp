class Solution {
public:
    int getLength(ListNode* head) {
        int length = 0;
        ListNode* current = head;
        while (current) {
            length++;
            current = current->next;
        }
        return length;
    }

    ListNode* addHelper(ListNode* l1, ListNode* l2, int diff, int& carry) {
        if (!l1 && !l2) {
            return nullptr;
        }

        ListNode* currentSumNode = nullptr;

        if (diff == 0) {
            currentSumNode = addHelper(l1->next, l2->next, 0, carry);
            int sum = l1->val + l2->val + carry;
            carry = sum / 10;
            ListNode* newNode = new ListNode(sum % 10);
            newNode->next = currentSumNode;
            return newNode;
        } else {
            currentSumNode = addHelper(l1->next, l2, diff - 1, carry);
            int sum = l1->val + carry;
            carry = sum / 10;
            ListNode* newNode = new ListNode(sum % 10);
            newNode->next = currentSumNode;
            return newNode;
        }
    }

    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        int len1 = getLength(l1);
        int len2 = getLength(l2);

        int carry = 0;
        ListNode* resultHead = nullptr;

        if (len1 >= len2) {
            resultHead = addHelper(l1, l2, len1 - len2, carry);
        } else {
            resultHead = addHelper(l2, l1, len2 - len1, carry);
        }

        if (carry > 0) {
            ListNode* newHead = new ListNode(carry);
            newHead->next = resultHead;
            return newHead;
        } else {
            return resultHead;
        }
    }
};