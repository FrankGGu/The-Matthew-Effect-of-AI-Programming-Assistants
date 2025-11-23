public class Solution {

import java.util.*;

public class Solution {
    public int countTime(String time) {
        String[] parts = time.split(":");
        String hourPart = parts[0];
        String minutePart = parts[1];

        int count = 0;

        for (int h = 0; h <= 23; h++) {
            for (int m = 0; m <= 59; m++) {
                String hStr = String.format("%02d", h);
                String mStr = String.format("%02d", m);

                boolean match = true;
                for (int i = 0; i < 2; i++) {
                    if (hourPart.charAt(i) != '?' && hourPart.charAt(i) != hStr.charAt(i)) {
                        match = false;
                        break;
                    }
                }
                for (int i = 0; i < 2; i++) {
                    if (minutePart.charAt(i) != '?' && minutePart.charAt(i) != mStr.charAt(i)) {
                        match = false;
                        break;
                    }
                }
                if (match) {
                    count++;
                }
            }
        }

        return count;
    }
}
}