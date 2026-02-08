var repeatedStringMatch = function(a, b) {
    // Calculate the minimum number of times 'a' must be repeated
    // so that the repeated string is at least as long as 'b'.
    // If b is shorter than a, this will be 1.
    let reps = Math.ceil(b.length / a.length);

    // Construct the string by repeating 'a' 'reps' times.
    let currentA = a.repeat(reps);

    // Check if 'b' is a substring of 'currentA'.
    if (currentA.includes(b)) {
        return reps;
    }

    // If not found, 'b' might straddle the boundary of the 'reps'-th 'a'
    // and the '(reps + 1)'-th 'a'. So, we try one more repetition.
    currentA += a;
    reps++;
    if (currentA.includes(b)) {
        return reps;
    }

    // If 'b' is still not found, it means it's impossible to form 'b'
    // by repeating 'a'. The maximum number of 'a' blocks 'b' can span
    // is floor(b.length / a.length) + 2. The checks above cover this range.
    return -1;
};