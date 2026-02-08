import java.util.PriorityQueue;
import java.util.Comparator;

class Solution {
    public double maxAverageRatio(int[][] classes, int extraStudents) {
        PriorityQueue<int[]> pq = new PriorityQueue<>(new Comparator<int[]>() {
            @Override
            public int compare(int[] a, int[] b) {
                // Calculate the potential gain in pass ratio if one extra student is added to class 'a'
                // Current ratio: pass_a / total_a
                // New ratio: (pass_a + 1) / (total_a + 1)
                // Gain = (pass_a + 1) / (total_a + 1) - pass_a / total_a
                //      = ( (pass_a + 1) * total_a - pass_a * (total_a + 1) ) / (total_a * (total_a + 1))
                //      = ( pass_a * total_a + total_a - pass_a * total_a - pass_a ) / (total_a * (total_a + 1))
                //      = (total_a - pass_a) / (total_a * (total_a + 1))

                double gainA = (double)(a[1] - a[0]) / ((long)a[1] * (a[1] + 1)); // Use long for denominator to prevent overflow before casting to double
                double gainB = (double)(b[1] - b[0]) / ((long)b[1] * (b[1] + 1));

                // We want a max-heap based on gain, so elements with higher gain should have higher priority (come first).
                // If gainA is less than gainB, 'a' should come after 'b' (return positive).
                // If gainA is greater than gainB, 'a' should come before 'b' (return negative).
                if (gainA < gainB) {
                    return 1;
                } else if (gainA > gainB) {
                    return -1;
                } else {
                    return 0;
                }
            }
        });

        // Initialize the priority queue with all classes
        for (int[] cls : classes) {
            pq.offer(cls);
        }

        // Distribute extra students greedily
        for (int i = 0; i < extraStudents; i++) {
            int[] currentClass = pq.poll(); // Get the class that provides the maximum gain
            currentClass[0]++; // Add one passed student
            currentClass[1]++; // Add one total student
            pq.offer(currentClass); // Add the updated class back to the priority queue
        }

        // Calculate the sum of pass ratios after distributing all extra students
        double totalPassRatioSum = 0.0;
        while (!pq.isEmpty()) {
            int[] cls = pq.poll();
            totalPassRatioSum += (double)cls[0] / cls[1];
        }

        // Calculate the average pass ratio
        return totalPassRatioSum / classes.length;
    }
}