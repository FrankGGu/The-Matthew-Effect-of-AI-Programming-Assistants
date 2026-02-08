import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public int[] countVisitedNodes(List<Integer> edges) {
        int n = edges.size();
        int[] ans = new int[n];
        Arrays.fill(ans, 1);
        for (int start = 0; start < n; start++) {
            if (ans[start] > 1) continue;
            int slow = start, fast = start;
            while (true) {
                slow = edges.get(slow);
                fast = edges.get(edges.get(fast));
                if (slow == fast) break;
            }
            int cycleLength = 1;
            int temp = edges.get(slow);
            while (temp != slow) {
                cycleLength++;
                temp = edges.get(temp);
            }
            int cycleStart = slow;
            for (int i = 0; i < cycleLength; i++) {
                ans[cycleStart] = cycleLength;
                cycleStart = edges.get(cycleStart);
            }

            for (int i = 0; i < n; i++) {
                if (ans[i] > 1) continue;
                int curr = i;
                int length = 0;
                List<Integer> path = new ArrayList<>();
                while (ans[curr] == 1) {
                    path.add(curr);
                    curr = edges.get(curr);
                    if (ans[curr] > 1) break;
                    length++;
                }
                if (ans[curr] > 1) {
                    for (int node : path) {
                        ans[node] = length + 1 + ans[curr] - (curr == edges.get(node) && ans[curr] == 1 ? 0 : 0);
                        length--;
                    }
                }
            }
        }
        return ans;
    }
}