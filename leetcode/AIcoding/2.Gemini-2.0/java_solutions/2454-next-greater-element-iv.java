import java.util.PriorityQueue;
import java.util.Stack;

class Solution {
    public int[] secondGreaterElement(int[] nums) {
        int n = nums.length;
        int[] res = new int[n];
        for (int i = 0; i < n; i++) {
            res[i] = -1;
        }

        Stack<Integer> s1 = new Stack<>();
        Stack<Integer> s2 = new Stack<>();
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        for (int i = 0; i < n; i++) {
            while (!pq.isEmpty() && pq.peek()[0] < nums[i]) {
                res[pq.poll()[1]] = nums[i];
            }

            while (!s2.isEmpty() && nums[s2.peek()] < nums[i]) {
                pq.offer(new int[]{nums[s2.pop()], i});
            }

            while (!s1.isEmpty() && nums[s1.peek()] < nums[i]) {
                s2.push(s1.pop());
            }

            s1.push(i);

            while(!s2.isEmpty() && (s1.isEmpty() || nums[s1.peek()] >= nums[s2.peek()])) {
                s1.push(s2.pop());
            }
        }

        return res;
    }
}