class Solution {
    public int maximumDifference(int num) {
        String s = String.valueOf(num);
        char[] minArr = s.toCharArray();
        char[] maxArr = s.toCharArray();

        for (int i = 0; i < minArr.length; i++) {
            if (minArr[i] != '0' && minArr[i] != '9') {
                minArr[i] = '0';
                break;
            }
        }

        for (int i = 0; i < maxArr.length; i++) {
            if (maxArr[i] != '9') {
                maxArr[i] = '9';
                break;
            }
        }

        int minNum = Integer.parseInt(String.valueOf(minArr));
        int maxNum = Integer.parseInt(String.valueOf(maxArr));

        return maxNum - minNum;
    }
}