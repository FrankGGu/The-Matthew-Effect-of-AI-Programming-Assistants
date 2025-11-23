public class Solution extends Relation {
    public int findCelebrity(int n) {
        if (n <= 0) {
            return -1;
        }

        int candidate = 0;
        for (int i = 1; i < n; i++) {
            if (knows(candidate, i)) {
                // If candidate knows i, then candidate cannot be the celebrity.
                // i might be the celebrity, so update candidate.
                candidate = i;
            }
            // Else (candidate does not know i), then i cannot be the celebrity
            // because a celebrity must be known by everyone else (including candidate).
            // So, candidate remains the same.
        }

        // At this point, 'candidate' is the only person who could possibly be the celebrity.
        // We need to verify two conditions for 'candidate':
        // 1. 'candidate' knows no one else.
        // 2. Everyone else knows 'candidate'.

        for (int i = 0; i < n; i++) {
            if (i == candidate) {
                continue; // Skip checking against self
            }

            // Check condition 1: candidate knows no one else
            if (knows(candidate, i)) {
                return -1; // If candidate knows i, candidate is not the celebrity.
            }

            // Check condition 2: everyone else knows candidate
            if (!knows(i, candidate)) {
                return -1; // If i does not know candidate, candidate is not the celebrity.
            }
        }

        // If both conditions are satisfied for all other people, then 'candidate' is the celebrity.
        return candidate;
    }
}