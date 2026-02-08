public class Solution {

import java.util.LinkedList;
import java.util.Queue;

public class Solution {
    public int countStudents(int[] students, int[] sandwiches) {
        Queue<Integer> queue = new LinkedList<>();
        for (int student : students) {
            queue.add(student);
        }

        int i = 0;
        while (i < sandwiches.length && !queue.isEmpty()) {
            if (queue.peek() == sandwiches[i]) {
                queue.poll();
                i++;
            } else {
                break;
            }
        }

        return queue.size();
    }
}
}