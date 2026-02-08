class Solution {
    public long maxOperations(String s) {
        long operations = 0;
        int onesCount = 0;

        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '1') {
                onesCount++;
            } else { // s.charAt(i) == '0'
                // When a '0' is encountered, all '1's that appeared before it
                // can be moved past this '0'. Each such move costs 1 operation.
                // The '11' swaps (cost 0) allow any '1' to be brought adjacent
                // to this '0' without additional cost, if it needs to pass other '1's.
                // Thus, we add the current count of '1's to the total operations.
                operations += onesCount;
            }
        }

        return operations;
    }
}