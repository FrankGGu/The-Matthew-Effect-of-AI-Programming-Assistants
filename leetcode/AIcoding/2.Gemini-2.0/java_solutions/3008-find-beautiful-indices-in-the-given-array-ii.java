import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> beautifulIndices(String s, String a, String b, int k) {
        List<Integer> aIndices = new ArrayList<>();
        List<Integer> bIndices = new ArrayList<>();
        List<Integer> result = new ArrayList<>();

        for (int i = 0; i <= s.length() - a.length(); i++) {
            if (s.substring(i, i + a.length()).equals(a)) {
                aIndices.add(i);
            }
        }

        for (int i = 0; i <= s.length() - b.length(); i++) {
            if (s.substring(i, i + b.length()).equals(b)) {
                bIndices.add(i);
            }
        }

        for (int i = 0; i < aIndices.size(); i++) {
            int aIndex = aIndices.get(i);
            boolean found = false;
            for (int j = 0; j < bIndices.size(); j++) {
                int bIndex = bIndices.get(j);
                if (Math.abs(aIndex - bIndex) <= k) {
                    found = true;
                    break;
                }
            }
            if (found) {
                result.add(aIndex);
            }
        }

        return result;
    }
}