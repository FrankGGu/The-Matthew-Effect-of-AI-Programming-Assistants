import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> ambiguousCoordinates(String s) {
        s = s.substring(1, s.length() - 1);
        List<String> result = new ArrayList<>();
        for (int i = 1; i < s.length(); i++) {
            String s1 = s.substring(0, i);
            String s2 = s.substring(i);
            List<String> validX = valid(s1);
            List<String> validY = valid(s2);

            for (String x : validX) {
                for (String y : validY) {
                    result.add("(" + x + ", " + y + ")");
                }
            }
        }
        return result;
    }

    private List<String> valid(String s) {
        List<String> result = new ArrayList<>();
        if (s.length() == 1 || s.charAt(0) != '0') {
            result.add(s);
        }

        for (int i = 1; i < s.length(); i++) {
            String left = s.substring(0, i);
            String right = s.substring(i);
            if ((left.length() > 1 && left.charAt(0) == '0') || right.charAt(right.length() - 1) == '0') {
                continue;
            }
            result.add(left + "." + right);
        }

        List<String> filteredResult = new ArrayList<>();
        for(String str : result){
            if(str.contains(".") && str.startsWith("0") && str.length() > 1 && str.charAt(1) != '.'){
                continue;
            }
            if(!str.contains(".") && str.length() > 1 && str.startsWith("0")){
                continue;
            }
            filteredResult.add(str);
        }

        if(s.length() > 1 && s.startsWith("0") && !filteredResult.contains(s) && !s.contains(".")){
            return new ArrayList<>();
        }

        return filteredResult;
    }
}