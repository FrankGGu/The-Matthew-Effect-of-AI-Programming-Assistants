public class Solution {

import java.util.*;

public class Solution {
    public String[] guessDynastry(String[] artifacts, String[] dynasties) {
        Map<String, String> artifactToDynasty = new HashMap<>();
        for (String artifact : artifacts) {
            String[] parts = artifact.split(" ");
            String name = parts[0];
            int year = Integer.parseInt(parts[1]);
            String dynasty = "";
            for (String d : dynasties) {
                String[] dParts = d.split(" ");
                String dName = dParts[0];
                int start = Integer.parseInt(dParts[1]);
                int end = Integer.parseInt(dParts[2]);
                if (year >= start && year <= end) {
                    dynasty = dName;
                    break;
                }
            }
            artifactToDynasty.put(name, dynasty);
        }
        String[] result = new String[artifacts.length];
        for (int i = 0; i < artifacts.length; i++) {
            String[] parts = artifacts[i].split(" ");
            result[i] = artifactToDynasty.get(parts[0]);
        }
        return result;
    }
}
}