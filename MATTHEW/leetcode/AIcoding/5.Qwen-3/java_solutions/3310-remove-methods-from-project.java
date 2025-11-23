public class Solution {

import java.util.*;

public class Solution {
    public List<String> removeMethodsFromProject(List<String> project) {
        Set<String> methodNames = new HashSet<>();
        List<String> result = new ArrayList<>();

        for (String line : project) {
            if (line.trim().startsWith("public") && line.contains("(") && line.contains(")")) {
                int start = line.indexOf(" ");
                int end = line.indexOf("(");
                String methodName = line.substring(start + 1, end).trim();
                methodNames.add(methodName);
            }
        }

        for (String line : project) {
            boolean isMethod = false;
            if (line.trim().startsWith("public") && line.contains("(") && line.contains(")")) {
                int start = line.indexOf(" ");
                int end = line.indexOf("(");
                String methodName = line.substring(start + 1, end).trim();
                if (methodNames.contains(methodName)) {
                    isMethod = true;
                }
            }
            if (!isMethod) {
                result.add(line);
            }
        }

        return result;
    }
}
}