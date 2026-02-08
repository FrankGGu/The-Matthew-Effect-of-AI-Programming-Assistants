class Solution {
    public boolean checkIfCanBreak(String s1, String s2) {
        char[] arr1 = s1.toCharArray();
        char[] arr2 = s2.toCharArray();
        Arrays.sort(arr1);
        Arrays.sort(arr2);
        boolean flag1 = true, flag2 = true;
        for (int i = 0; i < arr1.length; i++) {
            if (arr1[i] < arr2[i]) {
                flag1 = false;
            }
            if (arr2[i] < arr1[i]) {
                flag2 = false;
            }
            if (!flag1 && !flag2) {
                return false;
            }
        }
        return true;
    }
}