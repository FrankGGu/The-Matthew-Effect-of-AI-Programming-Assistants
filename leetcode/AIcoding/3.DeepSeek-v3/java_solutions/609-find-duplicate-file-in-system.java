class Solution {
    public List<List<String>> findDuplicate(String[] paths) {
        Map<String, List<String>> map = new HashMap<>();
        for (String path : paths) {
            String[] parts = path.split(" ");
            String dir = parts[0];
            for (int i = 1; i < parts.length; i++) {
                String file = parts[i];
                int leftBracket = file.indexOf('(');
                String fileName = file.substring(0, leftBracket);
                String content = file.substring(leftBracket + 1, file.length() - 1);
                String fullPath = dir + "/" + fileName;
                map.putIfAbsent(content, new ArrayList<>());
                map.get(content).add(fullPath);
            }
        }
        List<List<String>> result = new ArrayList<>();
        for (List<String> group : map.values()) {
            if (group.size() > 1) {
                result.add(group);
            }
        }
        return result;
    }
}