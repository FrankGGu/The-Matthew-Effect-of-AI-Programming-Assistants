class Solution {
    public String[] alternateGroups(String[] arr) {
        List<String> group1 = new ArrayList<>();
        List<String> group2 = new ArrayList<>();

        for (int i = 0; i < arr.length; i++) {
            if (i % 2 == 0) {
                group1.add(arr[i]);
            } else {
                group2.add(arr[i]);
            }
        }

        String[] result = new String[group1.size() + group2.size()];
        int index = 0;

        for (String s : group1) {
            result[index++] = s;
        }

        for (String s : group2) {
            result[index++] = s;
        }

        return result;
    }
}