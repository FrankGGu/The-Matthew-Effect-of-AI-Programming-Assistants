var strongPasswordChecker = function(password) {
    let missingTypes = 3;
    if (/[a-z]/.test(password)) missingTypes--;
    if (/[A-Z]/.test(password)) missingTypes--;
    if (/\d/.test(password)) missingTypes--;

    let replace = 0;
    let oneSeq = 0, twoSeq = 0;
    let i = 2;
    while (i < password.length) {
        if (password[i] === password[i-1] && password[i-1] === password[i-2]) {
            let length = 2;
            while (i < password.length && password[i] === password[i-1]) {
                length++;
                i++;
            }
            replace += Math.floor(length / 3);
            if (length % 3 === 0) oneSeq++;
            else if (length % 3 === 1) twoSeq++;
        } else {
            i++;
        }
    }

    if (password.length < 6) {
        return Math.max(missingTypes, 6 - password.length);
    } else if (password.length <= 20) {
        return Math.max(missingTypes, replace);
    } else {
        let deleteCount = password.length - 20;
        replace -= Math.min(deleteCount, oneSeq * 1) / 1;
        replace -= Math.min(Math.max(deleteCount - oneSeq, 0), twoSeq * 2) / 2;
        replace -= Math.max(deleteCount - oneSeq - 2 * twoSeq, 0) / 3;
        return deleteCount + Math.max(missingTypes, replace);
    }
};