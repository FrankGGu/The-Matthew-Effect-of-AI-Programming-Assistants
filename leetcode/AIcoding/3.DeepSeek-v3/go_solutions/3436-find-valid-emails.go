import (
    "regexp"
)

func validEmails(emails []string) []string {
    var res []string
    pattern := `^[a-zA-Z][a-zA-Z0-9._-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`
    re := regexp.MustCompile(pattern)

    for _, email := range emails {
        if re.MatchString(email) {
            res = append(res, email)
        }
    }
    return res
}