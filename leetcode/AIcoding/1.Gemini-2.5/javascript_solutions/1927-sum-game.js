var sumGame = function(num) {
    let s1 = 0;
    let s2 = 0;
    let q1 = 0;
    let q2 = 0;
    const n = num.length;
    const half = n / 2;

    for (let i = 0; i < half; i++) {
        if (num[i] === '?') {
            q1++;
        } else {
            s1 += parseInt(num[i]);
        }
    }

    for (let i = half; i < n; i++) {
        if (num[i] === '?') {
            q2++;
        } else {
            s2 += parseInt(num[i]);
        }
    }

    const initialDiff = s1 - s2;
    const qDiff = q1 - q2;

    // If the number of question marks in both halves is equal (qDiff = 0),
    // Bob can always mirror Alice's moves to keep the sum difference unchanged.
    // So, Bob wins if the initial sum difference is 0. Alice wins otherwise.
    if (qDiff === 0) {
        return initialDiff !== 0;
    }

    // If the number of question marks is different (qDiff != 0),
    // The "paired" question marks (min(q1, q2) in each half) will be filled in a way that Bob
    // tries to keep the difference at 0, and Alice tries to make it non-zero.
    // Bob can counter Alice's moves for these paired question marks to ensure a net change of 0 to the difference.
    // This leaves |qDiff| "unpaired" question marks, all in one half.
    // These |qDiff| question marks will be filled by players.
    // Alice gets ceil(|qDiff| / 2) turns for these unpaired question marks.
    // Bob gets floor(|qDiff| / 2) turns for these unpaired question marks.

    // If qDiff > 0 (more '?' in the first half):
    // Alice will fill her ceil(qDiff / 2) '?'s with 9 to maximize the difference.
    // Bob will fill his floor(qDiff / 2) '?'s with 0 to minimize the difference.
    // Net change from these '?'s = 9 * ceil(qDiff / 2).

    // If qDiff < 0 (more '?' in the second half):
    // Alice will fill her ceil(|qDiff| / 2) '?'s in the second half with 9 to decrease the difference (s1-s2).
    // Bob will fill his floor(|qDiff| / 2) '?'s in the second half with 0 to keep the difference from changing.
    // Net change from these '?'s = -9 * ceil(|qDiff| / 2).

    // This can be combined:
    // The total change from the '?'s is sign(qDiff) * 9 * ceil(abs(qDiff) / 2).
    // The final difference will be initialDiff + total_change_from_q_marks.
    const finalDiffChange = Math.sign(qDiff) * 9 * Math.ceil(Math.abs(qDiff) / 2);
    const finalDiff = initialDiff + finalDiffChange;

    // Bob wins if finalDiff is 0. Alice wins if finalDiff is not 0.
    return finalDiff !== 0;
};