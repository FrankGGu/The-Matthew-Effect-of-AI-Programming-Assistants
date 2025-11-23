import java.util.*;

public class Solution {
    public List<String> removeSubfolders(String[] folder) {
        Arrays.sort(folder);
        List<String> result = new ArrayList<>();
        String prev = "";

        for (String f : folder) {
            if (!f.startsWith(prev + "/")) {
                result.add(f);
                prev = f;
            }
        }

        return result;
    }
}