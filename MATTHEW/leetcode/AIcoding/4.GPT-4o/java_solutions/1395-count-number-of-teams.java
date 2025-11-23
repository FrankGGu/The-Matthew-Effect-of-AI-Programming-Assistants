class Solution {
    public int numTeams(int[] rating) {
        int count = 0;
        int n = rating.length;

        for (int i = 0; i < n; i++) {
            int leftLess = 0, leftGreater = 0, rightLess = 0, rightGreater = 0;
            for (int j = 0; j < n; j++) {
                if (rating[j] < rating[i]) {
                    if (j < i) leftLess++;
                    else rightLess++;
                } else if (rating[j] > rating[i]) {
                    if (j < i) leftGreater++;
                    else rightGreater++;
                }
            }
            count += leftLess * rightGreater + leftGreater * rightLess;
        }

        return count;
    }
}