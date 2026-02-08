function strWithout3a3b(A, B) {
    let result = '';
    while (A > 0 || B > 0) {
        if (A > B) {
            if (A > 1) {
                result += 'aa';
                A -= 2;
            } else {
                result += 'a';
                A -= 1;
            }
            if (B > 0) {
                result += 'b';
                B -= 1;
            }
        } else {
            if (B > 1) {
                result += 'bb';
                B -= 2;
            } else {
                result += 'b';
                B -= 1;
            }
            if (A > 0) {
                result += 'a';
                A -= 1;
            }
        }
    }
    return result;
}