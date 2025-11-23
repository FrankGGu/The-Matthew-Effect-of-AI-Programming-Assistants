type StringBuilder struct {
    str string
}

func Constructor() StringBuilder {
    return StringBuilder{str: ""}
}

func (this *StringBuilder) Append(str string) StringBuilder {
    this.str += str
    return *this
}

func (this *StringBuilder) DeleteAll() StringBuilder {
    this.str = ""
    return *this
}

func (this *StringBuilder) GetString() string {
    return this.str
}