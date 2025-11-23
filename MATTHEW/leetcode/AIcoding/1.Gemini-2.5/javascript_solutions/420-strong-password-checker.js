var strongPasswordChecker = function(s) {
    const n = s.length;

    let hasLower = false;
    let hasUpper = false;
    let hasDigit = false;
    for (let i = 0; i < n; i++) {
        const charCode = s.charCodeAt(i);
        if (charCode >= 97 && charCode <= 122) {
            hasLower = true;
        } else if (charCode >= 65 && charCode <= 90) {
            hasUpper = true;
        } else if (charCode >= 48 && charCode <= 57) {
            hasDigit = true;
        }
    }
    let missingTypes = (!hasLower ? 1 : 0) + (!hasUpper ? 1 : 0) + (!hasDigit ? 1 : 0);

    let replacementsNeededForRepeats = 0;
    let rem0 = 0;
    let rem1 = 0;
    let rem2 = 0;

    let i = 0;
    while (i < n) {
        let j = i;
        while (j < n && s[j] === s[i]) {
            j++;
        }
        let length = j - i;
        if (length >= 3) {
            replacementsNeededForRepeats += Math.floor(length / 3);
            if (length % 3 === 0) {
                rem0++;
            } else if (length % 3 === 1) {
                rem1++;
            } else {
                rem2++;
            }
        }
        i = j;
    }

    if (n < 6) {
        return Math.max(6 - n, missingTypes, replacementsNeededForRepeats);
    } else if (n > 20) {
        let deletionsNeeded = n - 20;
        let totalChanges = deletionsNeeded;

        let canUse1del = Math.min(deletionsNeeded, rem0);
        deletionsNeeded -= canUse1del;
        replacementsNeededForRepeats -= canUse1del;

        let canUse2del = Math.min(Math.floor(deletionsNeeded / 2), rem1);
        deletionsNeeded -= canUse2del * 2;
        replacementsNeededForRepeats -= canUse2del;

        replacementsNeededForRepeats -= Math.floor(deletionsNeeded / 3);

        totalChanges += Math.max(missingTypes, replacementsNeededForRepeats);
        return totalChanges;

    } else {
        return Math.max(missingTypes, replacementsNeededForRepeats);
    }
};