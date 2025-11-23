var countVowelStrings = function(n) {
    // This problem can be solved using combinations with repetition.
    // We are choosing 'n' vowels from 5 types (a, e, i, o, u)
    // such that the resulting string is sorted.
    // This is equivalent to finding the number of combinations with repetition
    // of choosing 'n' items from 'k' distinct types, where k=5.
    // The formula for combinations with repetition is C(n + k - 1, k - 1) or C(n + k - 1, n).
    // Here, n is the input 'n', and k is 5 (for the 5 vowels).
    // So, the formula becomes C(n + 5 - 1, 5 - 1) = C(n + 4, 4).
    // C(N, K) = N! / (K! * (N-K)!)
    // C(n + 4, 4) = (n + 4)! / (4! * (n + 4 - 4)!)
    //             = (n + 4)! / (4! * n!)
    //             = (n + 4) * (n + 3) * (n + 2) * (n + 1) / (4 * 3 * 2 * 1)
    //             = (n + 4) * (n + 3) * (n + 2) * (n + 1) / 24

    return (n + 4) * (n + 3) * (n + 2) * (n + 1) / 24;
};