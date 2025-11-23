class Solution {
    public long minimumPossibleSum(int n, int target) {
        long sum = 0;
        int count = 0;
        int num = 1;
        while (count < n) {
            if (num * 2 <= target) {
                sum += num;
                count++;
            } else if (target - num <= 0) {
                sum += num;
                count++;
            }
            else if (target - num > num){
                sum += num;
                count++;
            }
            num++;
            if (num >= target / 2 + target % 2 && count < n) {
                num = target / 2 + target % 2;
                while(count < n){
                    sum += num;
                    count++;
                    num++;
                }
            }
        }
        return sum;
    }
}