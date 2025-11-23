class Solution {
    public int countStudents(int[] students, int[] sandwiches) {
        int count = 0;
        int n = students.length;
        int m = sandwiches.length;

        for (int i = 0; i < n; i++) {
            if (students[i] == sandwiches[count]) {
                count++;
            } else {
                int j = i;
                while (j < n && students[j] != sandwiches[count]) {
                    j++;
                }
                if (j == n) break;
                count++;
            }
        }

        return n - count;
    }
}