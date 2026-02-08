class Solution {
    public String alphabetBoardPath(String target) {
        StringBuilder sb = new StringBuilder();
        int currR = 0;
        int currC = 0;

        for (char ch : target.toCharArray()) {
            int targetR = (ch - 'a') / 5;
            int targetC = (ch - 'a') % 5;

            // Adjust coordinates for 'z'
            if (ch == 'z') {
                targetR = 5;
                targetC = 0;
            }

            // Calculate differences
            int dr = targetR - currR;
            int dc = targetC - currC;

            // Movement logic based on special conditions involving 'z'
            if (ch == 'z') { 
                // To move TO 'z', we must be in column 0 first.
                // Move horizontally to column 0 if not already there.
                // dc will be 0 - currC, so if currC > 0, dc < 0, meaning we move 'L'.
                for (int i = 0; i < Math.abs(dc); i++) {
                    sb.append('L'); 
                }
                // Then move vertically
                for (int i = 0; i < Math.abs(dr); i++) {
                    if (dr > 0) sb.append('D'); // targetR > currR, move Down
                    else sb.append('U'); // targetR < currR, move Up (or dr=0, loop won't run)
                }
            } else if (currR == 5 && currC == 0) { 
                // Moving FROM 'z', must move 'U' first
                sb.append('U');
                currR = 4; // Temporarily update currR to (4,0) for subsequent calculations

                // Recalculate dr and dc based on new currR (and original currC=0)
                dr = targetR - currR; // targetR - 4
                dc = targetC - currC; // targetC - 0

                // Then move vertically
                for (int i = 0; i < Math.abs(dr); i++) {
                    if (dr > 0) sb.append('D'); // targetR > currR, move Down
                    else sb.append('U'); // targetR < currR, move Up
                }
                // Then move horizontally
                for (int i = 0; i < Math.abs(dc); i++) {
                    if (dc > 0) sb.append('R'); // targetC > currC, move Right
                    else sb.append('L'); // targetC < currC, move Left
                }
            } else { 
                // General case: neither current nor target is 'z' (or current is not 'z' and target is not 'z')
                // Move vertically first
                for (int i = 0; i < Math.abs(dr); i++) {
                    if (dr > 0) sb.append('D'); // targetR > currR, move Down
                    else sb.append('U'); // targetR < currR, move Up
                }
                // Then move horizontally
                for (int i = 0; i < Math.abs(dc); i++) {
                    if (dc > 0) sb.append('R'); // targetC > currC, move Right
                    else sb.append('L'); // targetC < currC, move Left
                }
            }

            sb.append('!');
            currR = targetR;
            currC = targetC;
        }

        return sb.toString();
    }
}