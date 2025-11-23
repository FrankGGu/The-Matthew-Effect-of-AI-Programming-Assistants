var maskPersonalInformation = function(s, x) {
    let email = s.toLowerCase();
    let atIndex = email.indexOf('@');
    let domain = email.substring(atIndex);
    let local = email.substring(0, atIndex);

    if (local.length > 1) {
        local = local[0] + '*****' + local.slice(-1);
    } else {
        local = local[0] + '*';
    }

    let phone = s.replace(/[^0-9]/g, '');
    let length = phone.length;
    let areaCode = '';

    if (length === 10) {
        areaCode = '(' + phone.substring(0, 3) + ') ';
    } else if (length === 11) {
        areaCode = '(' + phone.substring(0, 3) + ') ';
    } else if (length === 12) {
        areaCode = '(' + phone.substring(0, 3) + ') ';
    } else if (length === 13) {
        areaCode = '(' + phone.substring(0, 3) + ') ';
    }

    let lastFour = phone.substring(length - 4);
    let middle = '***-' + lastFour;

    return local + domain + ' ' + areaCode + middle;
};