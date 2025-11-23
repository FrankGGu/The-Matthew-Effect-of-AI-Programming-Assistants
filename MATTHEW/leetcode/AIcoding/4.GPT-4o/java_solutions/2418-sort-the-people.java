import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public String[] sortPeople(String[] names, int[] heights) {
        String[][] people = new String[names.length][2];
        for (int i = 0; i < names.length; i++) {
            people[i][0] = names[i];
            people[i][1] = String.valueOf(heights[i]);
        }
        Arrays.sort(people, new Comparator<String[]>() {
            public int compare(String[] a, String[] b) {
                return Integer.parseInt(b[1]) - Integer.parseInt(a[1]);
            }
        });
        String[] sortedNames = new String[names.length];
        for (int i = 0; i < names.length; i++) {
            sortedNames[i] = people[i][0];
        }
        return sortedNames;
    }
}