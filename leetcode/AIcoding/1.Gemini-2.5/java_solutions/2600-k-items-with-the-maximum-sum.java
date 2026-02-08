class Solution {
    public int kItemsWithMaximumSum(int numOnes, int numZeros, int numNegOnes, int k) {
        int sum = 0;

        // Take items with value 1
        int takeOnes = Math.min(k, numOnes);
        sum += takeOnes;
        k -= takeOnes;

        // If k is still positive, take items with value 0
        if (k > 0) {
            int takeZeros = Math.min(k, numZeros);
            // sum remains unchanged as value is 0
            k -= takeZeros;
        }

        // If k is still positive, take items with value -1
        if (k > 0) {
            int takeNegOnes = Math.min(k, numNegOnes);
            sum -= takeNegOnes;
            // k -= takeNegOnes; // Not strictly necessary as we are done
        }

        return sum;
    }
}