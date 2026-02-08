var crackPassword = function(password) {
    password.sort((a, b) => {
        const strA = a.toString();
        const strB = b.toString();
        return (strA + strB).localeCompare(strB + strA);
    });

    let result = password.join('');
    return result;
};