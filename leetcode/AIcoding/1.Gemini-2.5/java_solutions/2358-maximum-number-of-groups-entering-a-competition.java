import java.util.Arrays;

class Solution {
    public int maximumGroups(int[] grades) {
        int n = grades.length;

        // The problem asks for the maximum number of groups 'm' such that:
        // 1. Each group 'i' has k_i students, and k_1 < k_2 < ... < k_m.
        // 2. The sum of grades S_i in group 'i' is S_1 < S_2 < ... < S_m.

        // To maximize 'm', we should choose the smallest possible group sizes that satisfy the first condition.
        // This means k_i = i.
        // So, group 1 has 1 student, group 2 has 2 students, ..., group m has m students.
        // The total number of students required for 'm' groups is the sum of an arithmetic progression:
        // 1 + 2 + ... + m = m * (m + 1) / 2.

        // This total number of students must be less than or equal to the total available students 'n'.
        // So, we need to find the maximum integer 'm' such that m * (m + 1) / 2 <= n.

        // Now, consider the second condition: S_1 < S_2 < ... < S_m.
        // The problem statement specifies that `1 <= grades[i] <= 10^9`. This is a crucial constraint.
        // If we sort the `grades` array in ascending order (g_0 <= g_1 <= ... <= g_{n-1})
        // and assign students to groups sequentially (Group 1 gets g_0, Group 2 gets g_1, g_2, etc.),
        // the sum condition S_{i+1} > S_i will always be satisfied.
        // This is because:
        // a) Group i+1 has strictly more students (i+1) than Group i (i).
        // b) All grades are strictly positive (>= 1).
        // c) Students for Group i+1 are taken from later (equal or higher grade) positions in the sorted array
        //    compared to students for Group i.
        // With more students, all having positive grades, and those students generally having higher grades,
        // the sum of grades for Group i+1 will always be strictly greater than Group i.

        // Therefore, the problem simplifies to finding the maximum 'm' such that m * (m + 1) / 2 <= n.

        // We solve the quadratic inequality m^2 + m - 2n <= 0 for m.
        // The positive root of the equation m^2 + m - 2n = 0 is given by the quadratic formula:
        // m = (-1 + sqrt(1 - 4 * 1 * (-2n))) / 2
        // m = (-1 + sqrt(1 + 8n)) / 2
        // We need the largest integer 'm' that satisfies the inequality, so we take the floor of this value.

        // Calculate the discriminant (1 + 8n)
        // Using long for 8L * n to prevent potential overflow if n is very large, though for n=10^5, 8*n fits in int.
        long discriminant = 1 + 8L * n; 
        double sqrtDiscriminant = Math.sqrt(discriminant);

        // Calculate m using the formula and cast to int (which performs floor for positive numbers).
        int m = (int) ((-1 + sqrtDiscriminant) / 2);

        return m;
    }
}