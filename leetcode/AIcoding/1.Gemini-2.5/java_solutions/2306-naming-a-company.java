import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

class Solution {
    public long distinctNames(String[] ideas) {
        List<Set<String>> groups = new ArrayList<>(26);
        for (int i = 0; i < 26; i++) {
            groups.add(new HashSet<>());
        }

        for (String idea : ideas) {
            char firstChar = idea.charAt(0);
            String suffix = idea.substring(1);
            groups.get(firstChar - 'a').add(suffix);
        }

        long ans = 0;
        for (int i = 0; i < 26; i++) {
            for (int j = i + 1; j < 26; j++) {
                Set<String> set_i = groups.get(i);
                Set<String> set_j = groups.get(j);

                int commonSuffixes = 0;
                for (String suffix : set_i) {
                    if (set_j.contains(suffix)) {
                        commonSuffixes++;
                    }
                }

                // Let c_i be the character 'a' + i, and c_j be the character 'a' + j.
                // We are looking for pairs (company1, company2) where:
                // company1 = c_i + s1 (s1 is a suffix in set_i)
                // company2 = c_j + s2 (s2 is a suffix in set_j)
                // And after swapping first letters:
                // new_company1 = c_j + s1 must exist (meaning s1 must also be in set_j)
                // new_company2 = c_i + s2 must exist (meaning s2 must also be in set_i)
                //
                // So, s1 must be a suffix common to both set_i and set_j.
                // And s2 must be a suffix common to both set_i and set_j.
                //
                // The number of choices for s1 is `commonSuffixes`.
                // The number of choices for s2 is `commonSuffixes`.
                // This gives `commonSuffixes * commonSuffixes` pairs of (c_i + s1, c_j + s2).
                //
                // The problem counts (company1, company2) and (company2, company1) as distinct pairs.
                // If (c_i + s1, c_j + s2) satisfies the condition, then
                // (c_j + s2, c_i + s1) also satisfies the condition (swapping its first letters results in c_i + s2 and c_j + s1, which exist).
                // Therefore, for each combination of common suffixes (s1, s2), we count 2 distinct pairs.
                ans += 2L * commonSuffixes * commonSuffixes;
            }
        }

        return ans;
    }
}