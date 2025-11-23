public class Solution {

import java.util.*;

public class HappyStudents {
    public int countHappyStudents(int[] students, int[] sandwiches) {
        Queue<Integer> queue = new LinkedList<>();
        for (int student : students) {
            queue.add(student);
        }

        int[] count = new int[2];
        for (int sandwich : sandwiches) {
            count[sandwich]++;
        }

        int i = 0;
        while (i < sandwiches.length && !queue.isEmpty()) {
            int current = queue.peek();
            if (current == sandwiches[i]) {
                queue.poll();
                count[sandwiches[i]]--;
                i++;
            } else {
                if (count[current] == 0) {
                    break;
                }
                queue.poll();
                queue.add(current);
            }
        }

        return queue.size();
    }
}
}