class Solution {
    public String[] selectData(String[] arr) {
        int count = 0;
        for (String s : arr) {
            if (s.length() > 5) {
                count++;
            }
        }

        String[] result = new String[count];
        int index = 0;
        for (String s : arr) {
            if (s.length() > 5) {
                result[index++] = s;
            }
        }

        return result;
    }
}