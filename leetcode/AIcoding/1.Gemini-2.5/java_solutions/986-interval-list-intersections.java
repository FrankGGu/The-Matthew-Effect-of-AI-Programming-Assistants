import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[][] intervalIntersection(int[][] firstList, int[][] secondList) {
        List<int[]> result = new ArrayList<>();
        int i = 0;
        int j = 0;

        while (i < firstList.length && j < secondList.length) {
            int startA = firstList[i][0];
            int endA = firstList[i][1];
            int startB = secondList[j][0];
            int endB = secondList[j][1];

            int intersectionStart = Math.max(startA, startB);
            int intersectionEnd = Math.min(endA, endB);

            if (intersectionStart <= intersectionEnd) {
                result.add(new int[]{intersectionStart, intersectionEnd});
            }

            if (endA < endB) {
                i++;
            } else {
                j++;
            }
        }

        return result.toArray(new int[result.size()][]);
    }
}