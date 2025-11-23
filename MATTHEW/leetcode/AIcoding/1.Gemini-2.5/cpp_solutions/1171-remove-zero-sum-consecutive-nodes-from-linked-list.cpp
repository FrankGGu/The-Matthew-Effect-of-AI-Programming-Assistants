#include <map>

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

class Solution {
public:
    ListNode* removeZeroSumSublists(ListNode* head) {
        ListNode* dummy = new ListNode(0);
        dummy->next = head;

        std::map<int, ListNode*> prefix_sum_to_node;
        prefix_sum_to_node[0] = dummy;

        int current_sum = 0;
        ListNode* ptr = dummy->next;

        while (ptr != nullptr) {
            current_sum += ptr->val;

            if (prefix_sum_to_node.count(current_sum)) {
                // Found a zero-sum sequence. It starts from prefix_sum_to_node[current_sum]->next and ends at ptr.
                ListNode* node_before_segment = prefix_sum_to_node[current_sum];
                ListNode* node_after_segment = ptr->next;

                // Remove entries from map for nodes in the segment (exclusive of node_before_segment, inclusive of ptr)
                // The prefix sum at node_before_segment (which is current_sum) should remain in the map.
                // We need to remove prefix sums of nodes from node_before_segment->next up to ptr.
                ListNode* temp_node = node_before_segment->next;
                int temp_sum_val = current_sum; // This is the prefix sum at node_before_segment

                while (temp_node != ptr) { 
                    temp_sum_val += temp_node->val;
                    prefix_sum_to_node.erase(temp_sum_val);
                    temp_node = temp_node->next;
                }

                // Link node_before_segment to node_after_segment, effectively removing the segment.
                node_before_segment->next = node_after_segment;

                // Reset ptr to node_before_segment so that the next iteration effectively starts from its new next.
                ptr = node_before_segment;
                // current_sum is already the prefix sum at node_before_segment, so no change needed.
            } else {
                // No zero-sum sequence ending at ptr found. Store ptr in map.
                prefix_sum_to_node[current_sum] = ptr;
            }
            // Move ptr forward for the next iteration.
            ptr = ptr->next;
        }

        return dummy->next;
    }
};