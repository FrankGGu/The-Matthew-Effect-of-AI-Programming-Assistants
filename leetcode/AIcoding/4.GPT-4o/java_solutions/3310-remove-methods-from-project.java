import java.util.*;

public class Solution {
    public List<String> removeMethods(List<String> methods, List<String> toRemove) {
        Set<String> toRemoveSet = new HashSet<>(toRemove);
        List<String> result = new ArrayList<>();
        for (String method : methods) {
            String[] parts = method.split("\\s+");
            if (parts.length > 1) {
                String methodName = parts[1];
                if (!toRemoveSet.contains(methodName)) {
                    result.add(method);
                }
            }
        }
        return result;
    }
}