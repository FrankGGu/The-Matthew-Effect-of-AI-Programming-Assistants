import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] nodesBetweenCriticalPoints(ListNode head) {
        List<Integer> criticalPointsIndices = new ArrayList<>();

        if (head == null || head.next == null || head.next.next == null) {
            return new int[]{-1, -1};
        }

        ListNode prevNode = head;
        ListNode currNode = head.next;
        ListNode nextNode = head.next.next;
        int position = 1; // current node's index, starting from 1 for head.next

        while (nextNode != null) {
            boolean isCritical = false;
            if (currNode.val > prevNode.val && currNode.val > nextNode.val) {
                isCritical = true; // Local maximum
            } else if (currNode.val < prevNode.val && currNode.val < nextNode.val) {
                isCritical = true; // Local minimum
            }

            if (isCritical) {
                criticalPointsIndices.add(position);
            }

            prevNode = currNode;
            currNode = nextNode;
            nextNode = nextNode.next;
            position++;
        }

        if (criticalPointsIndices.size() < 2) {
            return new int[]{-1, -1};
        }

        int minDistance = Integer.MAX_VALUE;
        int maxDistance = criticalPointsIndices.get(criticalPointsIndices.size() - 1) - criticalPointsIndices.get(0);

        for (int i = 0; i < criticalPointsIndices.size() - 1; i++) {
            minDistance = Math.min(minDistance, criticalPointsIndices.get(i + 1) - criticalPointsIndices.get(i));
        }

        return new int[]{minDistance, maxDistance};
    }
}