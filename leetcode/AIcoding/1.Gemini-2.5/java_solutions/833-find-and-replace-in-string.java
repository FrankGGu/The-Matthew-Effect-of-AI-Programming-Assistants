import java.util.HashMap;
import java.util.Map;

class Solution {

    private static class ReplacementInfo {
        String source;
        String target;

        ReplacementInfo(String source, String target) {
            this.source = source;
            this.target = target;
        }
    }

    public String findReplaceString(String s, int[] indices, String[] sources, String[] targets) {
        Map<Integer, ReplacementInfo> replacementMap = new HashMap<>();

        for (int i = 0; i < indices.length; i++) {
            replacementMap.put(indices[i], new ReplacementInfo(sources[i], targets[i]));
        }

        StringBuilder result = new StringBuilder();
        int currentIdx = 0;

        while (currentIdx < s.length()) {
            if (replacementMap.containsKey(currentIdx)) {
                ReplacementInfo info = replacementMap.get(currentIdx);
                String source = info.source;
                String target = info.target;

                if (s.regionMatches(currentIdx, source, 0, source.length())) {
                    result.append(target);
                    currentIdx += source.length();
                } else {
                    result.append(s.charAt(currentIdx));
                    currentIdx++;
                }
            } else {
                result.append(s.charAt(currentIdx));
                currentIdx++;
            }
        }

        return result.toString();
    }
}