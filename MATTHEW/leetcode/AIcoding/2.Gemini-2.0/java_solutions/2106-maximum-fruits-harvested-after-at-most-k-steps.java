class Solution {
    public int maxTotalFruits(int[][] fruits, int startPos, int k) {
        int n = fruits.length;
        int left = 0;
        int right = n - 1;
        while (left < right) {
            int mid = (left + right) / 2;
            if (fruits[mid][0] < startPos) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        int startIndex = left;
        int ans = 0;
        for (int i = startIndex; i < n; i++) {
            int stepsRight = fruits[i][0] - startPos;
            if (stepsRight > k) {
                break;
            }
            int sum = 0;
            for (int j = startIndex; j <= i; j++) {
                sum += fruits[j][1];
            }
            int remaining = k - stepsRight;
            int l = startIndex;
            int r = startIndex;
            int tempSum = sum;
            while (l > 0 && (startPos - fruits[l - 1][0]) <= remaining) {
                l--;
                tempSum += fruits[l][1];
            }
            ans = Math.max(ans, tempSum);
            l = startIndex;
            r = startIndex;
            tempSum = sum;
            for(int j = startIndex; j >= 0; j--){
                int stepsLeft = startPos - fruits[j][0];
                if(stepsLeft > k) break;
                sum = 0;
                 for (int m = j; m <= i; m++) {
                   sum += fruits[m][1];
                }
                remaining = k - stepsLeft;
                 int ri = i;
                int le = i;
                while (ri < n - 1 && (fruits[ri + 1][0] - startPos) <= remaining) {
                    ri++;
                    sum += fruits[ri][1];
                }
                ans = Math.max(ans,sum);

            }

        }
        int l = startIndex;
        int r = startIndex;
        for(int j = startIndex; j >= 0; j--){
            int stepsLeft = startPos - fruits[j][0];
            if(stepsLeft > k) break;
              int sum = 0;
                 for (int m = j; m <=startIndex; m++) {
                   sum += fruits[m][1];
                }
            int remaining = k - stepsLeft;
                 int ri = startIndex;
                int le = startIndex;
                while (ri < n - 1 && (fruits[ri + 1][0] - startPos) <= remaining) {
                    ri++;
                    sum += fruits[ri][1];
                }
                ans = Math.max(ans,sum);
        }
        l = startIndex;
        r = startIndex;
        int sum = 0;
        for(int i = startIndex; i < n; i++){
            if(fruits[i][0] - startPos <= k){
                sum += fruits[i][1];
            }
        }

        l = startIndex;
         r = startIndex;
         for(int i = startIndex; i >= 0; i--){
            if(startPos - fruits[i][0] <= k){
                sum += fruits[i][1];
            }
        }

        int res = 0;
        sum = 0;
        for(int i = startIndex; i < n; i++){
            int stepsRight = fruits[i][0] - startPos;
            if(stepsRight > k) break;
            sum += fruits[i][1];
            res = Math.max(res, sum);
        }
        sum = 0;
         for(int i = startIndex; i >= 0; i--){
            int stepsLeft = startPos - fruits[i][0];
            if(stepsLeft > k) break;
            sum += fruits[i][1];
            res = Math.max(res, sum);
        }

        return Math.max(ans, res);
    }
}