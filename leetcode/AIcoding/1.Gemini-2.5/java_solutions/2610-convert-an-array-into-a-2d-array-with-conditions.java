import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> findMatrix(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();

        // A frequency array to keep track of how many times each number has been placed
        // The index represents the number (1 to 200), and the value represents the count
        // Max value of nums[i] is 200, so an array of size 201 is sufficient (index 0 unused).
        int[] count = new int[201]; 

        for (int num : nums) {
            // The value `count[num]` indicates which row this current `num` should be placed in.
            // For the first occurrence of `num`, `count[num]` will be 0, so it goes into row 0.
            // For the second occurrence, `count[num]` will be 1, so it goes into row 1, and so on.
            // This ensures that each row contains distinct integers, as each occurrence of a number
            // is placed into a different row index.

            // If `count[num]` is equal to the current number of rows in `result`,
            // it means all existing rows already contain previous occurrences of some numbers
            // up to this depth, and we need to create a new row to accommodate this `num`.
            if (count[num] >= result.size()) {
                result.add(new ArrayList<>());
            }

            // Add the current number `num` to the row determined by `count[num]`.
            result.get(count[num]).add(num);

            // Increment the count for this number, preparing for its next occurrence.
            count[num]++;
        }

        return result;
    }
}