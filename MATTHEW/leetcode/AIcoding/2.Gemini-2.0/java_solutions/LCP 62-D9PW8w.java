import java.util.*;

class Solution {
    public int transportationHub(int[][] paths) {
        if (paths == null || paths.length == 0) {
            return -1;
        }

        Set<Integer> nodes = new HashSet<>();
        for (int[] path : paths) {
            nodes.add(path[0]);
            nodes.add(path[1]);
        }

        int n = nodes.size();
        if (n == 0) {
            return -1;
        }

        for (int i = 0; i < n; i++) {
            int inDegree = 0;
            int outDegree = 0;
            Set<Integer> inNodes = new HashSet<>();
            Set<Integer> outNodes = new HashSet<>();

            for (int[] path : paths) {
                if (path[1] == i) {
                    inDegree++;
                    inNodes.add(path[0]);
                }
                if (path[0] == i) {
                    outDegree++;
                    outNodes.add(path[1]);
                }
            }

            if (inDegree == n - 1 && outDegree == 0) {
                boolean allIn = true;
                for(int j=0; j<n; j++){
                    if(j!=i && !inNodes.contains(j)){
                        allIn = false;
                        break;
                    }
                }
                if(allIn){
                    return i;
                }

            }
        }

        return -1;
    }
}