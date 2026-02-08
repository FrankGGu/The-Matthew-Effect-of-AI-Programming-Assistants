import java.util.ArrayList;
import java.util.List;

class Solution {
    public int magicalString(int n) {
        if (n <= 0) {
            return 0;
        }
        if (n <= 3) {
            return 1;
        }

        List<Integer> s = new ArrayList<>();
        s.add(1);
        s.add(2);
        s.add(2);

        int head = 2; 
        int tail = 3; 
        int numOnes = 1; 

        int charToAppend = 1; 

        while (tail < n) {
            int count = s.get(head); 

            for (int i = 0; i < count; i++) {
                if (tail < n) {
                    s.add(charToAppend);
                    if (charToAppend == 1) {
                        numOnes++;
                    }
                    tail++;
                } else {
                    break; 
                }
            }

            charToAppend = (charToAppend == 1) ? 2 : 1;
            head++;
        }

        return numOnes;
    }
}