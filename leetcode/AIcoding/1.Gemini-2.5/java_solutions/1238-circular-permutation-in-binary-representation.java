import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> circularPermutation(int n, int start) {
        List<Integer> result = new ArrayList<>();
        int size = 1 << n; // Calculate 2^n

        for (int i = 0; i < size; i++) {
            // Generate the i-th number in the standard Gray code sequence
            // G(i) = i ^ (i >> 1)
            int grayCode = i ^ (i >> 1);

            // Transform the standard Gray code to start with 'start'
            // The property (A ^ C) ^ (B ^ C) = A ^ B ensures that
            // the difference property is maintained.
            // Since G(0) = 0, P(0) = G(0) ^ start = 0 ^ start = start.
            result.add(grayCode ^ start);
        }

        return result;
    }
}