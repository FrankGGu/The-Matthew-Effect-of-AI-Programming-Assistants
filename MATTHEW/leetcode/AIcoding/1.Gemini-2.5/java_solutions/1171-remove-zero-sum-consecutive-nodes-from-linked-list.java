import java.util.HashMap;
import java.util.Map;

class Solution {
    public ListNode removeZeroSumSublists(ListNode head) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;

        Map<Integer, ListNode> prefixSumToNode = new HashMap<>();

        int currentPrefixSum = 0;
        ListNode current = dummy;

        // The map stores (prefixSum, node_that_achieved_this_prefixSum).
        // It always stores the LATEST node that achieved a certain prefix sum.
        // We put (0, dummy) initially to handle cases where the entire list sums to zero or starts with a zero-sum segment.
        prefixSumToNode.put(0, dummy); 

        // Iterate through the list
        while (current != null) {
            currentPrefixSum += current.val; // Calculate prefix sum up to and including current node

            if (prefixSumToNode.containsKey(currentPrefixSum)) {
                // A zero-sum sublist is found.
                // 'prev' is the node where 'currentPrefixSum' was previously achieved.
                // The sublist to remove is from 'prev.next' to 'current' (inclusive).
                ListNode prev = prefixSumToNode.get(currentPrefixSum);

                // Remove entries from the map for nodes within the zero-sum segment.
                // These are nodes from 'prev.next' up to 'current'.
                // The prefix sum at 'prev' (which is 'currentPrefixSum') should NOT be removed from the map,
                // as 'prev' is still part of the list and its prefix sum is valid.
                ListNode temp = prev.next;
                int sumToRemove = currentPrefixSum; // This is the prefix sum at 'prev'
                                                    // We need to remove prefix sums for 'temp', 'temp.next', ..., 'current'.
                while (temp != current.next) { // Iterate from prev.next to current (inclusive)
                    sumToRemove += temp.val; // 'sumToRemove' now represents prefix sum at 'temp'
                    // Only remove the entry if the map's stored node for 'sumToRemove' is 'temp'.
                    // This prevents removing 'prev's entry if 'sumToRemove' happens to equal 'currentPrefixSum' again.
                    if (prefixSumToNode.get(sumToRemove) == temp) {
                        prefixSumToNode.remove(sumToRemove); 
                    }
                    temp = temp.next;
                }

                // Link 'prev' to 'current.next', effectively removing the zero-sum sublist.
                prev.next = current.next;

                // After modifying the list, 'current' should point to 'prev'.
                // In the next iteration, 'current = current.next' will correctly move to 'prev.next'.
                // 'currentPrefixSum' is already correct (it's the sum at 'prev').
                current = prev; // This is crucial for correct continuation.
            } else {
                // If prefix sum not seen, add it to map
                prefixSumToNode.put(currentPrefixSum, current);
            }

            // Move to the next node
            current = current.next;
        }

        return dummy.next;
    }
}