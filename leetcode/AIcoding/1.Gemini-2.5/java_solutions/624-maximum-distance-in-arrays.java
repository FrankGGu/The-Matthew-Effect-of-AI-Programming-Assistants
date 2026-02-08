import java.util.List;

class Solution {
    public int maxDistance(List<List<Integer>> arrays) {
        int result = 0;

        // Initialize min_so_far and max_so_far with the first array's min and max values.
        // Since arrays are sorted, the first element is the minimum and the last is the maximum.
        int min_so_far = arrays.get(0).get(0);
        int max_so_far = arrays.get(0).get(arrays.get(0).size() - 1);

        // Iterate through the arrays starting from the second array (index 1).
        for (int i = 1; i < arrays.size(); i++) {
            List<Integer> current_array = arrays.get(i);
            int current_min = current_array.get(0);
            int current_max = current_array.get(current_array.size() - 1);

            // Calculate the maximum possible distance using the current array's max
            // and the minimum element encountered in any previous array.
            // This ensures the two elements come from different arrays.
            result = Math.max(result, Math.abs(current_max - min_so_far));

            // Calculate the maximum possible distance using the current array's min
            // and the maximum element encountered in any previous array.
            // This also ensures the two elements come from different arrays.
            result = Math.max(result, Math.abs(max_so_far - current_min));

            // Update min_so_far and max_so_far to include the current array's min and max.
            min_so_far = Math.min(min_so_far, current_min);
            max_so_far = Math.max(max_so_far, current_max);
        }

        return result;
    }
}