var compareVersion = function(version1, version2) {
    const v1 = version1.split('.');
    const v2 = version2.split('.');

    const maxLength = Math.max(v1.length, v2.length);

    for (let i = 0; i < maxLength; i++) {
        const num1 = parseInt(v1[i] || '0');
        const num2 = parseInt(v2[i] || '0');

        if (num1 > num2) {
            return 1;
        }
        if (num1 < num2) {
            return -1;
        }
    }

    return 0;
};