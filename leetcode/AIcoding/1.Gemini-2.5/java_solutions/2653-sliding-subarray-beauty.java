import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] getBeauty(int[] nums, int k, int x) {
        int[] freq = new int[101]; // Frequencies for numbers -50 to 50 (index 0 for -50, index 50 for 0, index 100 for 50)
        List<Integer> result = new ArrayList<>();

        // Initialize the first window
        for (int i = 0; i < k; i++) {
            freq[nums[i] + 50]++;
        }

        // Calculate beauty for the first window
        result.add(calculateBeauty(freq, x));

        // Slide the window
        for (int i = k; i < nums.length; i++) {
            // Remove the element leaving the window
            freq[nums[i - k] + 50]--;
            // Add the element entering the window
            freq[nums[i] + 50]++;
            // Calculate beauty for the current window
            result.add(calculateBeauty(freq, x));
        }

        // Convert List<Integer> to int[]
        int[] finalResult = new int[result.size()];
        for (int i = 0; i < result.size(); i++) {
            finalResult[i] = result.get(i);
        }

        return finalResult;
    }

    private int calculateBeauty(int[] freq, int x) {
        int count = 0;
        for (int i = 0; i <= 100; i++) {
            count += freq[i];
            if (count >= x) {
                int beautyValue = i - 50; // Convert index back to actual number
                return beautyValue < 0 ? beautyValue : 0;
            }
        }
        return 0; // Should not be reached given problem constraints (x <= k)
    }
}